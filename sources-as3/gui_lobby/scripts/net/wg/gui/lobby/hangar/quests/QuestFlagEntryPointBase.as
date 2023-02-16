package net.wg.gui.lobby.hangar.quests
{
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   
   public class QuestFlagEntryPointBase extends GFInjectComponent implements IHeaderSecondaryEntryPoint
   {
      
      private static const WIDTH:int = 66;
      
      private static const HEIGHT:int = 113;
      
      private static const MARGIN:int = 2;
       
      
      private var _alias:String;
      
      public function QuestFlagEntryPointBase()
      {
         super();
      }
      
      public function get alias() : String
      {
         return this._alias;
      }
      
      public function set alias(param1:String) : void
      {
         this._alias = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         setSize(WIDTH + MARGIN,HEIGHT + MARGIN);
      }
   }
}
