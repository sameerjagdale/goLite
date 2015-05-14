#ifndef __AST_NODE__
#define __AST_NODE__
#include<node-visitor.hpp>
namespace GCompiler{

    template<typename T>	
        class AstNode {
            public:
                virtual T visitNode( NodeVisitor<T>& visitor) {
                    return visitor.caseAstNode();
                }
        };

    template<>
        class AstNode<void> {
            virtual void visitNode(NodeVisitor<void>& visitor) {
                visitor.caseAstNode();
            }
        };

    template<typename T> 
        class Program : public AstNode<T> {
            public :
                virtual T visitNode(NodeVisitor<T> & visitor) {
                    return visitor.caseProgram();
                }
        };

    template<> 
        class Program<void> : public AstNode<void> {
            public :
                virtual void visitNode(NodeVisitor<void> & visitor) {
                     visitor.caseProgram();
                }
        };
    
}
#endif 
