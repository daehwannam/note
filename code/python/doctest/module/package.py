
def test():
    '''
    Example:

    >>> test()
    hi

    >>> total = 0
    >>> for x in range(1, 6):
    ...     total += x
    >>>
    >>> print(total)
    15
    '''
    print('hi')


if __name__ == "__main__":
    import doctest
    doctest.testmod()
