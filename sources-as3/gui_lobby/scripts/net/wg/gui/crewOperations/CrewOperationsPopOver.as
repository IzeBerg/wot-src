package net.wg.gui.crewOperations
{
   import flash.events.Event;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.infrastructure.base.meta.ICrewOperationsPopOverMeta;
   import net.wg.infrastructure.base.meta.impl.CrewOperationsPopOverMeta;
   import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
   import net.wg.infrastructure.interfaces.IWrapper;
   
   public class CrewOperationsPopOver extends CrewOperationsPopOverMeta implements ICrewOperationsPopOverMeta, ITutorialCustomComponent
   {
       
      
      public var list:CrewOperationsScrollingList;
      
      public function CrewOperationsPopOver()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.list.addEventListener(Event.RESIZE,this.onListResizeHandler,false,0,true);
         this.list.addEventListener(CrewOperationEvent.OPERATION_CHANGED,this.onCrewOperationChangedHandler,false,0,true);
      }
      
      override protected function onDispose() : void
      {
         this.list.removeEventListener(Event.RESIZE,this.onListResizeHandler);
         this.list.removeEventListener(CrewOperationEvent.OPERATION_CHANGED,this.onCrewOperationChangedHandler);
         this.list.disposeRenderers();
         this.list.dispose();
         this.list = null;
         super.onDispose();
      }
      
      override protected function update(param1:CrewOperationsInitVO) : void
      {
         this.list.dataProvider = param1.castedOperations;
         this.list.invalidateData();
         this.list.validateNow();
         setSize(this.list.width,this.list.height);
      }
      
      override public function set wrapper(param1:IWrapper) : void
      {
         super.wrapper = param1;
         PopOver(wrapper).title = CREW_OPERATIONS.WINDOW_TITLE;
      }
      
      private function onCrewOperationChangedHandler(param1:CrewOperationEvent) : void
      {
         param1.stopImmediatePropagation();
         invokeOperationS(param1.operationName);
         App.popoverMgr.hide();
      }
      
      private function onListResizeHandler(param1:Event) : void
      {
         setSize(this.list.width,this.list.height);
      }
      
      public function getTutorialDescriptionName() : String
      {
         return "";
      }
      
      public function needPreventInnerEvents() : Boolean
      {
         return true;
      }
      
      public function generatedUnstoppableEvents() : Boolean
      {
         return true;
      }
   }
}
