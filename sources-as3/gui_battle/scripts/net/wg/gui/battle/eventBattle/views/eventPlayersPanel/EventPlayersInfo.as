package net.wg.gui.battle.eventBattle.views.eventPlayersPanel
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class EventPlayersInfo extends BattleUIComponent
   {
       
      
      public var titleTF:TextField = null;
      
      public var pointsTF:TextField = null;
      
      public var pointsImage:MovieClip = null;
      
      public function EventPlayersInfo()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      public function setCountPoints(param1:uint) : void
      {
         this.pointsTF.text = param1.toString();
         this.pointsImage.visible = this.pointsTF.visible = param1 > 0;
      }
      
      override protected function onDispose() : void
      {
         this.titleTF = null;
         this.pointsTF = null;
         this.pointsImage = null;
         super.onDispose();
      }
   }
}
