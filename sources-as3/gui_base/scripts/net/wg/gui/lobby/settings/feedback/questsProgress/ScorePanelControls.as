package net.wg.gui.lobby.settings.feedback.questsProgress
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ScorePanelControls extends Sprite implements IDisposable
   {
      
      private static const REGULAR_STATE:String = "regular";
      
      private static const COLORBLIND_STATE:String = "colorblind";
      
      private static const NORMAL_Y:int = 0;
      
      private static const MIDDLE_Y:int = -8;
       
      
      public var scorePanelNoHPRegular:MovieClip = null;
      
      public var scorePanelHPValues:MovieClip = null;
      
      public var scorePanelHPDifference:MovieClip = null;
      
      public var scorePanelHPValuesAndDifference:MovieClip = null;
      
      public var scorePanelTierGrouping:MovieClip = null;
      
      public var scorePanelVehicleIconsRegular:MovieClip = null;
      
      public function ScorePanelControls()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function setVisibilityFlags(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         this.scorePanelHPValues.visible = param2 && !param3 && param1;
         this.scorePanelHPDifference.visible = !param2 && param3 && param1;
         this.scorePanelNoHPRegular.visible = !param2 && !param3 && param1;
         this.scorePanelHPValuesAndDifference.visible = param2 && param3 && param1;
         this.scorePanelVehicleIconsRegular.visible = !param4;
         this.scorePanelTierGrouping.visible = param4;
         if(param1)
         {
            this.scorePanelVehicleIconsRegular.y = NORMAL_Y;
            this.scorePanelTierGrouping.y = NORMAL_Y;
         }
         else
         {
            this.scorePanelVehicleIconsRegular.y = MIDDLE_Y;
            this.scorePanelTierGrouping.y = MIDDLE_Y;
         }
      }
      
      public function updateColorScheme(param1:Boolean) : void
      {
         var _loc2_:String = !!param1 ? COLORBLIND_STATE : REGULAR_STATE;
         this.scorePanelHPValues.gotoAndStop(_loc2_);
         this.scorePanelHPDifference.gotoAndStop(_loc2_);
         this.scorePanelNoHPRegular.gotoAndStop(_loc2_);
         this.scorePanelHPValuesAndDifference.gotoAndStop(_loc2_);
         this.scorePanelVehicleIconsRegular.gotoAndStop(_loc2_);
         this.scorePanelTierGrouping.gotoAndStop(_loc2_);
      }
      
      protected function onDispose() : void
      {
         this.scorePanelHPValues = null;
         this.scorePanelHPDifference = null;
         this.scorePanelHPValuesAndDifference = null;
         this.scorePanelTierGrouping = null;
         this.scorePanelVehicleIconsRegular = null;
         this.scorePanelNoHPRegular = null;
      }
   }
}
