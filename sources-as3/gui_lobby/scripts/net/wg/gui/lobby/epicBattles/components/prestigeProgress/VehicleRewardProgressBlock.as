package net.wg.gui.lobby.epicBattles.components.prestigeProgress
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import scaleform.clik.constants.InvalidationType;
   
   public class VehicleRewardProgressBlock extends PrestigeProgressBlock
   {
       
      
      public var descriptionTextfield:TextField = null;
      
      public var regularBackground:MovieClip = null;
      
      public var highlightedBackground:MovieClip = null;
      
      public function VehicleRewardProgressBlock()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.descriptionTextfield = null;
         this.regularBackground = null;
         this.highlightedBackground = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(dataVO != null && isInvalid(InvalidationType.DATA))
         {
            this.descriptionTextfield.htmlText = dataVO.descText;
            this.regularBackground.visible = !dataVO.canClaimVehicleReward;
            this.highlightedBackground.visible = dataVO.canClaimVehicleReward;
         }
      }
      
      override protected function setInternalText() : void
      {
         textfield.htmlText = dataVO.levelText;
      }
   }
}
