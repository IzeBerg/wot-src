package net.wg.infrastructure.tutorial.helpBtnControllers.interfaces
{
   import flash.events.IEventDispatcher;
   import net.wg.gui.components.advanced.vo.TutorialBtnControllerVO;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ITutorialHelpBtnController extends IDisposable, IEventDispatcher
   {
       
      
      function createHelpBtn() : void;
      
      function layoutHelpBtn() : void;
      
      function get model() : TutorialBtnControllerVO;
      
      function set model(param1:TutorialBtnControllerVO) : void;
      
      function get helpBtn() : SoundButtonEx;
      
      function get selected() : Boolean;
      
      function set selected(param1:Boolean) : void;
   }
}
