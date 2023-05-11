package net.wg.gui.battle.components.buttons.btnConfig
{
   import flash.geom.Point;
   
   public class BattleStateBtnSettings
   {
      
      public static const ALIGN_TO_CENTER:String = "alignToCenter";
       
      
      public var atlasItemName:String = "";
      
      public var alignImg:String = "";
      
      public var offsetImagePosition:Point = null;
      
      public function BattleStateBtnSettings(param1:String = "", param2:String = "", param3:Point = null)
      {
         super();
         this.atlasItemName = param1;
         this.alignImg = param2;
         this.offsetImagePosition = param3;
      }
   }
}
