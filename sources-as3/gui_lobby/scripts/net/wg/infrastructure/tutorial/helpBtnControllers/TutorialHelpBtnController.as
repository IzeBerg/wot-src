package net.wg.infrastructure.tutorial.helpBtnControllers
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.events.TutorialHelpBtnEvent;
   import net.wg.gui.components.advanced.vo.TutorialBtnControllerVO;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.tutorial.helpBtnControllers.interfaces.ITutorialHelpBtnController;
   import scaleform.clik.events.ButtonEvent;
   
   public class TutorialHelpBtnController extends EventDispatcher implements ITutorialHelpBtnController
   {
      
      private static const HELP_BTN_NAME:String = "helpBtn";
      
      private static const LAYOUT_ABSTRACT_INVOKE:String = "layoutHelpBtn" + Errors.ABSTRACT_INVOKE;
       
      
      protected var helpBtnLinkageId:String = "WindowHelpButtonUI";
      
      private var _view:AbstractView = null;
      
      private var _helpBtn:SoundButtonEx = null;
      
      private var _model:TutorialBtnControllerVO = null;
      
      public function TutorialHelpBtnController()
      {
         super();
      }
      
      public function createHelpBtn() : void
      {
         this._helpBtn = App.utils.classFactory.getObject(this.helpBtnLinkageId) as SoundButtonEx;
         App.utils.asserter.assertNotNull(this._helpBtn,"_helpBtn" + Errors.CANT_NULL);
         this._view.addChild(this._helpBtn);
         if(this._view.as_config.configVO.isResizable)
         {
            this._view.addEventListener(Event.RESIZE,this.onViewResizeHandler);
         }
         this._helpBtn.addEventListener(ButtonEvent.CLICK,this.onHelpBtnClickHandler);
         this._helpBtn.name = HELP_BTN_NAME;
         this.applyData();
         this.layoutHelpBtn();
      }
      
      public final function dispose() : void
      {
         this._view.removeEventListener(Event.RESIZE,this.onViewResizeHandler);
         this._helpBtn.removeEventListener(ButtonEvent.CLICK,this.onHelpBtnClickHandler);
         this._view = null;
         this._helpBtn.dispose();
         this._helpBtn = null;
         this._model = null;
      }
      
      public function layoutHelpBtn() : void
      {
         DebugUtils.LOG_ERROR(LAYOUT_ABSTRACT_INVOKE);
         throw new AbstractException(LAYOUT_ABSTRACT_INVOKE);
      }
      
      private function applyData() : void
      {
         if(this._model != null && this._helpBtn != null && this._model.btnTooltip != Values.EMPTY_STR)
         {
            this._helpBtn.tooltip = this._model.btnTooltip;
         }
      }
      
      public function get view() : AbstractView
      {
         return this._view;
      }
      
      public function set view(param1:AbstractView) : void
      {
         this._view = param1;
         App.utils.asserter.assertNotNull(this._view,"view as AbstractView" + Errors.CANT_NULL);
      }
      
      public function get model() : TutorialBtnControllerVO
      {
         return this._model;
      }
      
      public function set model(param1:TutorialBtnControllerVO) : void
      {
         this._model = param1;
         this.applyData();
      }
      
      public function get helpBtn() : SoundButtonEx
      {
         return this._helpBtn;
      }
      
      public function get selected() : Boolean
      {
         return this._helpBtn.selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(this._helpBtn.selected != param1)
         {
            this._helpBtn.selected = param1;
         }
      }
      
      private function onViewResizeHandler(param1:Event) : void
      {
         this.layoutHelpBtn();
      }
      
      private function onHelpBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new TutorialHelpBtnEvent(TutorialHelpBtnEvent.HELP_CLICK));
      }
   }
}
