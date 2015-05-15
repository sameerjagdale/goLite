#ifndef __NODE_VISITOR__
#define __NODE_VISITOR__
class NodeVisitor {
	public:
	virtual void caseAstNode();
    virtual void caseProgram();
};
#endif
