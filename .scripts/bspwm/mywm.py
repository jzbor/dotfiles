#! /bin/python3


class BspwmObject:
    def __init__(self, object_id):
        self.id = object_id



class Node (BspwmObject):
    def __init__(self, object_id):
        super().__init__(object_id)


class Desktop (BspwmObject):
    def __init__(self, object_id):
        super().__init__(object_id)


class Monitor (BspwmObject):
    def __init__(self, object_id):
        super().__init__(object_id)
