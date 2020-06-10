package game.controls
{

    public class Judge_Tweens
    {
        // "frame": [length, x, y, scaleX, scaleY, alpha, framelook];
        // lengths above 0 are considered tweens
        // framelook is a relative value where a tween looks ahead to find it's end values.

        public static var judge_indexes:Object = {"100": {
                    "0": [0.6, 0, 0, 1, 1, 1, 18],
                    "18": [0, 0, 0, 2.147, 1.907, 0, 1]
                },

                "50": {
                    "0": [0.6, 0, 0, 1, 1, 1, 18],
                    "18": [0, 0, 0, 2.147, 1.907, 0, 1]
                },

                "25": {
                    "0": [0.3333, 0, 0, 1, 1, 1, 10],
                    "10": [0.2667, 1, 1, 1.5, 1.5, 1, 8],
                    "18": [0, 1, 1, 1, 1, 0, 1]
                },

                "5": {
                    "0": [0.6, 0, 0, 1, 1, 1, 18],
                    "18": [0, 0, 0, 1, 1, 0, 1]
                },

                "-10": {
                    "0": [0.6, 0, 0, 1, 1, 1, 18],
                    "18": [0, 0, 30, 1, 1, 0, 1]
                },

                "-5": {
                    "0": [0, 0, 0, 1, 1, 1],
                    "1": [0, 5, 4, 1, 1, 1, 1],
                    "2": [0, -6, -8, 1, 1, 1, 1],
                    "3": [0, -2, 6, 1, 1, 1, 1],
                    "4": [0, 9, -8, 1, 1, 1, 1],
                    "5": [0, -4, 4, 1, 1, 1, 1],
                    "6": [0, 0, 0, 1, 1, 1, 1],
                    "7": [0, 5, 4, 1, 1, 1, 1],
                    "8": [0, -6, -8, 1, 1, 1, 1],
                    "9": [0, -2, 6, 1, 1, 1, 1],
                    "10": [0, 9, -8, 1, 1, 1, 1],
                    "11": [0.1, -4, 4, 1, 1, 1, 1],
                    "14": [0, -1, 1, 1, 1, 0.25, 1],
                    "15": [0, 0, 0, 1, 1, 0, 1]
                }}
    }
}
