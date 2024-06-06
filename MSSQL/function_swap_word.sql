USE [db]
GO

/**
 *	description: handler to swap adjacent characters in a string
 *	params:
 *		@string	-> word to swap
 *		@char	-> character used to replace empty space
 *	example: dbo.function_swap_word('hello world', '$') -> 'ehll oowlr d'
 *
 */

CREATE FUNCTION function_swap_word (
	@string nvarchar(4000),
	@char char
)
RETURNS nvarchar(4000)
BEGIN
	DECLARE @output nvarchar(4000);

	SET @string = REPLACE(
		IIF(LEN(@string) % 2 = 1, CONCAT(@string, @char), @string),
		' ',
		@char);

	WITH SplitChars AS (
		SELECT 
			SUBSTRING(@string, 1, 1) AS [Character],
			1 AS Position,
			1 AS [Mod]
		UNION ALL
		SELECT
			SUBSTRING(@string, Position + 1, 1),
			Position + 1,
			CASE
				WHEN Position % 2 = 0 THEN Position + 1
				ELSE Position - 1 
			END AS [Mod]
		FROM SplitChars
		WHERE Position < LEN(@string)
	)
	SELECT 
		@output = REPLACE(STRING_AGG([Character], ''), '$', ' ')
	FROM (
		SELECT
			--[Position],
			[Character]
			--[Mod]
		FROM SplitChars
		ORDER BY [Mod] OFFSET 0 ROWS
	) AS tmp
	OPTION (MAXRECURSION 0);

	RETURN @output;
END
GO

SELECT dbo.function_swap_word('hello world', '$');
