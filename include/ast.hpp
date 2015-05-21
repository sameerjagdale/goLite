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
            virtual void visitNode( NodeVisitor& visitor);
        private:
            NodeType nodeType;
    };

    using AstNodePtr = std::shared_ptr<AstNode>;
    using AstNodePtrList = std::vector<AstNodePtr>;

    class TopLevelDecl: public AstNode { 
        public :
            virtual void  visitNode(NodeVisitor& visitor);
    };

    using TopLevelDeclPtr = std::shared_ptr<TopLevelDecl>;
    using TopLevelDeclList = std::vector<TopLevelDeclPtr>;

    class Program : public AstNode {
        public :
            virtual void visitNode(NodeVisitor& visitor);
        private :
            const std::string packageName;
            TopLevelDeclList list;
    };
    using ProgramPtr = std::shared_ptr<Program>;

    class Statement : public AstNode {
        public :
            virtual void visitNode(NodeVisitor & visitor);
    };
    using StmtPtr = std::shared_ptr<Statement>;
    using StmtList = std::vector<StmtPtr>;
    
    class Decl : public TopLevelDecl, public Statement {
        public :
            virtual void visitNode(NodeVisitor& visitor);
    };
    using DeclPtr  = std::shared_ptr<Decl>;

    class VarDecl :  public Decl {
        public :
            virtual void visitNode(NodeVisitor& visitor);
    };
    using VarDeclPtr = std::shared_ptr<VarDecl>; 

    class VarSpec : public AstNode {
        public :
            virtual void visitNode(NodeVisitor & visitor);     
    };
    using VarSpecPtr = std::shared_ptr<VarSpec>;
    using VarSpecList = std::vector<VarSpecPtr>;
    

    class TypeDecl : public Decl {
        public :
            virtual void visitNode(NodeVisitor & visitor);
            
    };
    using TypeDeclPtr = std::shared_ptr<TypeDecl>;

    class TypeSpec : public Decl { 
        public :
            virtual void visitNode(NodeVisitor& visitor);
    }; 
    using TypeSpecPtr = std::shared_ptr<TypeSpec>;
    using TypeSpecList = std::vector<TypeSpecPtr>;

    class Function :  public TopLevelDecl {
        public : 
            virtual void visitNode(NodeVisitor& visitor);
        private: 
            std::string functionName;
    };
    using FunctionPtr = std::shared_ptr<Function>;
    using IdentifierList = std::vector<std::string>;

    class Type;
    using TypePtr = std::shared_ptr<Type>;
    class Param;
    using ParamPtr = std::shared_ptr<Param>;
    using ParamList = std::vector<ParamPtr>;

    class FuncSignature :  public AstNode {
        private :
            ParamList params;
    };

    class Param : public AstNode {
        private :
            IdentifierList idList;
            TypePtr type;   
    };
   
    class Type : public AstNode {
    };
    
    
    class BasicType : public Type {
         
    };
    
    class IntType : public BasicType {
        
    };

    class RuneType : public BasicType {
    };

    class FloatType : public BasicType {
    };
    
    class BoolType : public BasicType {
    };
    
    class StringType : public BasicType {
    };

    class Expr :  public AstNode {
        public : 
            virtual void visitNode(NodeVisitor & visitor);
    };
    using ExprPtr = std::shared_ptr<Expr>;
    using ExprList = std::vector<ExprPtr>;

    class PrintStmt : public Statement {
        ExprList exprList;
        public :
            virtual void visitNode(NodeVisitor & visitor);
    };
    using PrintStmtPtr = std::shared_ptr<PrintStmt>;
    
    class PrintlnStmt :  public PrintStmt {
    };
    using PrintlnStmtPtr  = std::shared_ptr<PrintlnStmt>;
    class RetStmt : public Statement { 
        public :
            virtual void visitNode(NodeVisitor& visitor);
        private:
            ExprPtr expr;
    };
    using RetStmtPtr  = std::shared_ptr<RetStmt>;

    class SimpleStmt : public Statement {
        public :
            virtual void visitNode(NodeVisitor& visitor);
    };
    using SimpleStmtPtr = std::shared_ptr<SimpleStmt>;
    
    class ExprStmt : public Statement {
        public :
            virtual void visitNode(NodeVisitor& visitor);
        private:
            ExprPtr expr; 
    };
    using ExprStmtPtr = std::shared_ptr<ExprStmt>;

    class IncStmt :  public SimpleStmt{
        public :
            virtual void visitNode(NodeVisitor& visitor);
        private :
           ExprPtr expr;  
    };
    using IncStmtPtr = std::shared_ptr<IncStmt>;

    class DecStmt : public SimpleStmt {
        public :
            virtual void visitNode(NodeVisitor& visitor);
        private :
            ExprPtr expr;
    };
    using DecStmtPtr = std::shared_ptr<DecStmt>;
    
    class AssignStmt :  public SimpleStmt {
        public :
            virtual void visitNode(NodeVisitor& visitor);
        private :
            ExprList lhsList;
            ExprList rhsList;
    };
    using AssignStmtPtr = std::shared_ptr<AssignStmt>;

    class ShortVarDecl : public AssignStmt {
        public:
            virtual void visitNode(NodeVisitor& visitor); 
    };
    using ShortVarDeclPtr  = std::shared_ptr<ShortVarDecl>;

    class IfCond : public AstNode {
        public :
            virtual void visitNode(NodeVisitor& visitor);
        private:
            SimpleStmtPtr stmt;
            ExprPtr expr;
    };
    using IfCondPtr = std::shared_ptr<IfCond>;

    class IfStmt : public Statement {
        IfCond cond;
        StmtList ifBlock;
        StmtList elseBlock; 
        public :
            virtual void visitNode(NodeVisitor& visitor);
    };
    using IfStmtPtr = std::shared_ptr<IfStmt>; 

}
#endif 
