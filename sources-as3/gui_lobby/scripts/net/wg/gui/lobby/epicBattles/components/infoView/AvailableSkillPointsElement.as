package net.wg.gui.lobby.epicBattles.components.infoView
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesInfoCombatReservesVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AvailableSkillPointsElement extends MovieClip implements IDisposable
   {
       
      
      public var skillPointsTF:TextField = null;
      
      public var pointsIcon:MovieClip = null;
      
      public var highlightDivider:MovieClip = null;
      
      public var greyDivider:MovieClip = null;
      
      public var pointsIconGlow:MovieClip = null;
      
      public function AvailableSkillPointsElement()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.pointsIconGlow = null;
         this.pointsIcon = null;
         this.skillPointsTF = null;
         this.highlightDivider = null;
         this.greyDivider = null;
      }
      
      public function setData(param1:EpicBattlesInfoCombatReservesVO) : void
      {
         this.skillPointsTF.htmlText = param1.unspentHtmlPointsText;
         this.highlightDivider.visible = this.pointsIconGlow.visible = param1.unspentPoints > 0;
         this.greyDivider.visible = param1.unspentPoints == 0;
      }
   }
}
