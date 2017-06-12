int getStatIncrease(int growth) {
	int stat = 0;
	
	if ((growth -= nextRN100()) >= 0)
		stat++;
	
	return stat;
}
