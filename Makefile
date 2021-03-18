GTEST_DIR = ./googletest/googletest




FILE = nombre

#        ^ 
#        |__ nombre (sin ; warro)


CPPFLAGS += -isystem $(GTEST_DIR)/include


CXXFLAGS += -g -Wall -Wextra -pthread -std=gnu++11


TESTS = $(FILE)_unittest


GTEST_HEADERS = $(GTEST_DIR)/include/gtest/*.h \
                $(GTEST_DIR)/include/gtest/internal/*.h



all : $(TESTS)

clean :
	@rm -f $(TESTS) gtest.a gtest_main.a *.o




GTEST_SRCS_ = $(GTEST_DIR)/src/*.cc $(GTEST_DIR)/src/*.h $(GTEST_HEADERS)


gtest-all.o : $(GTEST_SRCS_)
	$(CXX) $(CPPFLAGS) -I$(GTEST_DIR) $(CXXFLAGS) -c \
            $(GTEST_DIR)/src/gtest-all.cc

gtest_main.o : $(GTEST_SRCS_)
	$(CXX) $(CPPFLAGS) -I$(GTEST_DIR) $(CXXFLAGS) -c \
            $(GTEST_DIR)/src/gtest_main.cc

gtest.a : gtest-all.o
	$(AR) $(ARFLAGS) $@ $^

gtest_main.a : gtest-all.o gtest_main.o
	$(AR) $(ARFLAGS) $@ $^



$(FILE).o : $(FILE).hpp $(FILE).cpp

$(FILE)_unittest.o : $(FILE)_unittest.cc $(FILE).hpp

$(FILE)_unittest : $(FILE).o $(FILE)_unittest.o gtest_main.a
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $^ -o $@