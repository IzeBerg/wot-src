package net.wg.gui.lobby.techtree.interfaces
{
   public interface IResearchContainer extends INodesContainer
   {
       
      
      function hasUnlockedParent(param1:Number, param2:Number) : Boolean;
      
      function getTopLevel() : Vector.<IRenderer>;
      
      function getChildren(param1:IRenderer) : Vector.<IRenderer>;
   }
}
