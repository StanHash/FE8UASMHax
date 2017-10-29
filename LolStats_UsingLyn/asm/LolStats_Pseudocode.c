int GetStatIncrease(int growth) {
	int stat = 0;
	
	while ((growth -= nextRN100()) >= 0)
		stat++;
	
	return stat;
}
