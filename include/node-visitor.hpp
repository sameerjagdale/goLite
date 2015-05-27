#ifndef __NODE_VISITOR__
#define __NODE_VISITOR__
#include<memory>
namespace GCompiler {
    class NodeVisitor {
        public:
            virtual void caseAstNode();
            virtual void caseProgram();
            virtual void caseTopLevelDecl();
            virtual void caseStatement();
            virtual void caseDecl();
            virtual void caseVarDecl();
            virtual void caseVarSpec();
            virtual void caseTypeDecl();
            virtual void caseTypeSpec();
            virtual void caseFunction();
            virtual void caseType();
            virtual void caseParam();
            virtual void caseFuncSignature();
            virtual void caseBasicType();
            virtual void caseIntType();
            virtual void caseRuneType();
            virtual void caseFloatType();
            virtual void caseBoolType();
            virtual void caseStringType();
            virtual void caseExpr();
            virtual void casePrintStmt();
            virtual void casePrintlnStmt();
            virtual void caseRetStmt();
            virtual void caseSimpleStmt();
            virtual void caseExprStmt();
            virtual void caseIncStmt();
            virtual void caseDecStmt();
            virtual void caseAssignStmt();
            virtual void caseShortVarDecl();
            virtual void caseCondition();
            virtual void caseIfStmt();
            virtual void caseBreakStmt();
            virtual void caseContinueStmt();
            virtual void caseCaseClause();
            virtual void caseSwitchStmt();
            virtual void caseForStmtClause();
            virtual void caseBinaryExpr();
            virtual void caseUnaryExpr();
            virtual void casePrimaryExpr();
            virtual void caseNameExpr();
            virtual void caseFunCallExpr();
            virtual void caseConversionExpr();
            virtual void caseSelectorExpr();
            virtual void caseIndexExpr();
            virtual void caseSlice();
            virtual void caseSliceExpr();
            virtual void caseParenthesizedExpr();
            virtual void caseLiteralExpr(); 
            virtual void caseFloatLiteralExpr();
            virtual void caseIntLiteralExpr();
            virtual void caseRuneLiteralExpr();
            virtual void caseStringLiteralExpr();
            virtual void caseRawStringLiteralExpr();
    };
    using NodeVisitorPtr = std::shared_ptr<NodeVisitor>;
}
#endif
