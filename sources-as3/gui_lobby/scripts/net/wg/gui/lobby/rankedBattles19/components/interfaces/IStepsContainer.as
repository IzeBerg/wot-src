package net.wg.gui.lobby.rankedBattles19.components.interfaces
{
   import net.wg.gui.lobby.rankedBattles19.data.StepsContainerVO;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IStepsContainer extends IUIComponentEx, IResizableRankedComponent
   {
       
      
      function setData(param1:StepsContainerVO) : void;
      
      function tryDisposeSteps() : void;
      
      function runStepsShowAnimation(param1:Function = null) : void;
      
      function runStepsHideAnimation(param1:Function = null) : void;
      
      function useButtonMode(param1:Boolean) : void;
      
      function runStepsShineAnimation() : void;
      
      function getStepsState() : String;
      
      function get steps() : Vector.<IStepArrow>;
   }
}
