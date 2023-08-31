class Node:
    def __init__(self,data):
        self.data = data
        self.next = None

class Fila:
    def __init__(self):
        self.first = None
        self.last = None
        self.size = 0

    def push(self,elemento):
        node = Node(elemento)

        if self.last is None:
            self.last = node

        else:
            self.last.next = node
            self.last = node

        if self.first is None:
            self.first = node

        self.size += 1

    def peek(self):
        if self.empty():
            return 'Fila vazia'
        return self.first.data

    def pop(self):
        if self.empty():
            return 'fila vazia'
        elemento = self.first.data
        self.first = self.first.next

        if self.first is None:
            self.last = None

        self.size -= 1
        return elemento


    def __len__(self):
        return self.size

    def empty(self):
        return len(self) == 0

    def __repr__(self):
        if self.empty():
            return 'Fila Vazia, sem pedidos por enquanto'

        s = ''
        primeiro = self.first
        while (primeiro):
            s = s + str(primeiro.data)
            primeiro = primeiro.next
            if (primeiro):
                s = s + ' -> '
        return s

