chi_test.py

	import pandas as pd
	from scipy.stats import chi2_contingency

	# DataFrame
	df = pd.read_csv('input.csv', header=0)
	df.columns = ['Gene_selected_Dataset1', 'Total_genes_Dataset1', 
	              'Gene_selected_Dataset2', 'Total_genes_Dataset2', 'Term']

	# Check Gene Num
	assert df['Total_genes_Dataset1'].unique() == [487]
	assert df['Total_genes_Dataset2'].unique() == [22482]

	# Chi-Square test
	results = []
	for index, row in df.iterrows():
	    table = [
	        [row['Gene_selected_Dataset1'], row['Total_genes_Dataset1'] - row['Gene_selected_Dataset1']],
	        [row['Gene_selected_Dataset2'], row['Total_genes_Dataset2'] - row['Gene_selected_Dataset2']]
	    ]
	    chi2, p, dof, ex = chi2_contingency(table)
	    results.append((row['Term'], round(chi2, 4), round(p, 4)))  # 四舍五入到4位小数

	# DataFrame
	results_df = pd.DataFrame(results, columns=['Term', 'Chi2', 'P-Value'])
	print(results_df)

	# Save
	results_df.to_csv('chi_square_results.csv', index=False)

adjustp.py
	import numpy as np
	from statsmodels.stats.multitest import multipletests

	# Prepare_file
	input_file = 'enrichment_results2.txt'
	output_file = 'adjusted_enrichment_results.txt'

	# Extract p value
	p_values = []
	lines = []
	with open(input_file, 'r') as f:
	    for line in f:
	        parts = line.strip().split()
	        p_value = float(parts[1])  # 假设 p 值在第 2 列
	        p_values.append(p_value)
	        lines.append(parts)

	# p to numpy array
	p_values = np.array(p_values)

	# Benjamini-Hochberg
	rejected, p_adjusted, _, _ = multipletests(p_values, alpha=0.05, method='fdr_bh')

	# saving
	with open(output_file, 'w') as f:
	    for i in range(len(lines)):
	        f.write("\t".join(lines[i]) + f"\t{p_adjusted[i]}\n")

	print(f"Adjusted p-values have been saved to {output_file}")

