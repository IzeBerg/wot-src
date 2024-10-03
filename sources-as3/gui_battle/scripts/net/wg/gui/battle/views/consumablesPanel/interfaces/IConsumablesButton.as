package net.wg.gui.battle.views.consumablesPanel.interfaces
{
   import flash.geom.ColorTransform;
   import net.wg.gui.battle.components.buttons.interfaces.IBattleToolTipButton;
   import net.wg.gui.battle.views.consumablesPanel.VO.ConsumablesVO;
   
   public interface IConsumablesButton extends IBattleToolTipButton
   {
       
      
      function get consumablesVO() : ConsumablesVO;
      
      function set icon(param1:String) : void;
      
      function set key(param1:Number) : void;
      
      function set quantity(param1:int) : void;
      
      function setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:int = 1) : void;
      
      function setCoolDownPosAsPercent(param1:Number) : void;
      
      function setColorTransform(param1:ColorTransform) : void;
      
      function clearColorTransform() : void;
      
      function set activated(param1:Boolean) : void;
      
      function clearCoolDownTime() : void;
      
      function showGlow(param1:int) : void;
      
      function hideGlow() : void;
      
      function setTimerSnapshot(param1:int, param2:Boolean) : void;
      
      function get showConsumableBorder() : Boolean;
      
      function set showConsumableBorder(param1:Boolean) : void;
      
      function set isReplay(param1:Boolean) : void;
      
      function updateLockedInformation(param1:int, param2:String) : void;
      
      function updateLevelInformation(param1:int) : void;
      
      function setStage(param1:int) : void;
   }
}
