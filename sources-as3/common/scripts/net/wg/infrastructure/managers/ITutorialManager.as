package net.wg.infrastructure.managers
{
   import flash.display.DisplayObject;
   import net.wg.data.TutorialBuilderVO;
   import net.wg.infrastructure.base.meta.ITutorialManagerMeta;
   import net.wg.infrastructure.events.TutorialEvent;
   import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
   import net.wg.infrastructure.interfaces.ITutorialView;
   
   public interface ITutorialManager extends ITutorialManagerMeta
   {
       
      
      function onComponentCheckComplete(param1:String, param2:TutorialEvent, param3:String) : void;
      
      function onComponentCreatedByLinkage(param1:DisplayObject, param2:String) : void;
      
      function addListenersToCustomTutorialComponent(param1:ITutorialCustomComponent) : void;
      
      function removeListenersFromCustomTutorialComponent(param1:ITutorialCustomComponent) : void;
      
      function dispatchEventForCustomComponent(param1:ITutorialCustomComponent) : void;
      
      function setupEffectBuilder(param1:ITutorialView, param2:String, param3:TutorialBuilderVO, param4:DisplayObject) : void;
      
      function get isSystemEnabled() : Object;
      
      function setViewForTutorialId(param1:ITutorialView, param2:String) : void;
      
      function onEffectComplete(param1:DisplayObject, param2:String) : void;
   }
}
