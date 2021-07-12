package net.wg.gui.lobby.techtree.helpers
{
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   
   public class NodeIndexFilter
   {
       
      
      private var indexes:Array;
      
      public function NodeIndexFilter(param1:Array)
      {
         super();
         this.indexes = param1;
      }
      
      public function doFilter(param1:IRenderer, param2:int, param3:Vector.<IRenderer>) : Boolean
      {
         return param1 != null && this.indexes != null && this.indexes.indexOf(param2) > -1;
      }
   }
}
