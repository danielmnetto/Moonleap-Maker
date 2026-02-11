/// @description The function that approaches a number (current) to another (target) by given amount.
/// @param {real} current The current value used to approach to the target value.
/// @param {real} target The target value for the current value to approach.
/// @param {real} amount The amount to be incremented to the current value to reach the target value.
function approach(current, target, amount) {
	if (current < target) {
	    current = min(current + amount, target); 
	} else {
	    current = max(current - amount, target);
	}
	return current;
}
