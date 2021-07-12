package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicBattlesSkillViewMeta extends IEventDispatcher
   {
       
      
      function onEscapePressS() : void;
      
      function onBackBtnClickS() : void;
      
      function onCloseBtnClickS() : void;
      
      function onSelectSkillBtnClickS(param1:int) : void;
      
      function onSkillUpgradeS(param1:int) : void;
      
      function onSkillOverLevelS(param1:int, param2:int) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_updateData(param1:Object) : void;
      
      function as_setSelectedSkill(param1:int) : void;
      
      function as_setSkillDataBlock(param1:Object) : void;
   }
}
