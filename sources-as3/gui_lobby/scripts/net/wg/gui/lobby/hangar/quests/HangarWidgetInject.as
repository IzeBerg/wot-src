package net.wg.gui.lobby.hangar.quests
{
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   
   public class HangarWidgetInject extends GFInjectComponent implements IHeaderEntryPoint
   {
       
      
      private var _alias:String = "";
      
      public function HangarWidgetInject()
      {
         super();
      }
      
      public function get marginRight() : int
      {
         return 0;
      }
      
      public function get marginLeft() : int
      {
         return 0;
      }
      
      public function get marginTop() : int
      {
         return 0;
      }
      
      public function get alias() : String
      {
         return this._alias;
      }
      
      public function set alias(param1:String) : void
      {
         this._alias = param1;
      }
   }
}
