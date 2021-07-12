package net.wg.gui.battle.components.buttons.interfaces
{
   import net.wg.gui.battle.components.interfaces.IBattleUIComponent;
   
   public interface IBattleButton extends IBattleUIComponent
   {
       
      
      function get state() : String;
      
      function set state(param1:String) : void;
      
      function addClickCallBack(param1:IClickButtonHandler) : void;
      
      function addPressCallBack(param1:IPressButtonHandler) : void;
      
      function addReleaseOutSideCallBack(param1:IReleaseOutSideButtonHandler) : void;
      
      function addRollOverCallBack(param1:IRollOverButtonHandler) : void;
      
      function addRollOutCallBack(param1:IRollOutButtonHandler) : void;
      
      function addDragOverCallBack(param1:IDragOverButtonHandler) : void;
      
      function addDragOutCallBack(param1:IDragOutButtonHandler) : void;
      
      function addStateChangeCallBack(param1:IStateChangedButtonHandler) : void;
   }
}
