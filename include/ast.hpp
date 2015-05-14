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
    using AstNodePtr = std::shared_ptr<AstNode<T>>;

    template<typename T>  
    using AstNodePtrList = std::vector<AstNodePtr<T>>;

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

    template<typename T>
    using ProgramPtr = std::shared_ptr<Program<T>>;
    
}
#endif 
