package net.wg.gui.battle.interfaces
{
   import net.wg.gui.battle.components.interfaces.IBattleUIComponent;
   
   public interface IBattleInfo extends IBattleUIComponent
   {
       
      
      function resetByTimer() : void;
      
      function hideByTimer() : void;
      
      function hideInfo() : void;
      
      function showInfo() : void;
      
      function setData(param1:Object) : void;
      
      function updateStage(param1:int, param2:int) : void;
      
      function setHint(param1:String) : void;
      
      function get hasAnimation() : Boolean;
   }
}
