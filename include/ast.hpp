/*
   This file is part of goLite.

   goLite is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   Foobar is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with goLite.  If not, see <http://www.gnu.org/licenses/>.
   @author Sameer Jagdale
 */
// This file contains the classes require for building a AST for the compiler.
// Each class is templated to support the polymorphic visitor pattern.
// Alias declarations for shared pointer versions of each class. 
#ifndef __AST_NODE__
#define __AST_NODE__
#include<node-visitor.hpp>
#include<memory>
#include<vector>
#include<cstdint>
namespace GCompiler{
    // Base class of the AST. All nodes should inherit from the node 
    // directly or indirectly. 
    class AstNode {
        public:
            enum class NodeType : std::int32_t { 
                STMT_TYPE, 
                EXPR_TYPE,
                DECL_TYPE,
                PROG_TYPE
            };

            virtual void visitNode( NodeVisitor& visitor) {
                visitor.caseAstNode();
            }

        private:
            NodeType nodeType;
    };

    using AstNodePtr = std::shared_ptr<AstNode>;
    using AstNodePtrList = std::vector<AstNodePtr>;

    class TopLevelDecl: public AstNode { 
        public :
            virtual void  visitNode(NodeVisitor& visitor) {
            }
    };

    using TopLevelDeclPtr = std::shared_ptr<TopLevelDecl>;
    using TopLevelDeclList = std::vector<TopLevelDeclPtr>;

    class Program : public AstNode {
        public :
            virtual void visitNode(NodeVisitor& visitor) {
                return visitor.caseProgram();
            }
        private :
            const std::string packageName;
            TopLevelDeclList list;
    };

    using ProgramPtr = std::shared_ptr<Program>;

    class Statement : public AstNode {
        public :
            virtual void visitNode(NodeVisitor & visitor) {
            }
    };

    using StmtPtr = std::shared_ptr<Statement>;


    class Decl : public TopLevelDecl, public Statement {
        public :
            virtual void visitNode(NodeVisitor& visitor) {
            }
    };

    using DeclPtr  = std::shared_ptr<Decl>;

    class VarDecl :  public Decl {
        public :
            virtual void visitNode(NodeVisitor& visitor) {
            }
    };

    using VarDeclPtr = std::shared_ptr<VarDecl>; 

    class TypeDecl : public Decl {
        public :
            virtual void visitNode(NodeVisitor & visitor) {
            }
    };

    using TypeDeclPtr = std::shared_ptr<TypeDecl>;

    class Function :  public TopLevelDecl {
        public : 
            virtual void visitNode(NodeVisitor& visitor) {
            }

    };
    using FunctionPtr = std::shared_ptr<Function>;
}
#endif 
