#ifndef __NODE_VISITOR__
#define __NODE_VISITOR__
template<typename T> 
class NodeVisitor {
	public:
	virtual T caseAstNode();
};
#endif
