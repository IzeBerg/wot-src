package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BattleResultsTextData extends DAAPIDataClass
   {
       
      
      public var windowTitle:String = "";
      
      public var shareButtonLabel:String = "";
      
      public var shareButtonTooltip:String = "";
      
      public var replayButtonLabel:String = "";
      
      public var ownTitle:String = "";
      
      public var enemyTitle:String = "";
      
      public function BattleResultsTextData(param1:Object)
      {
         super(param1);
      }
   }
}
