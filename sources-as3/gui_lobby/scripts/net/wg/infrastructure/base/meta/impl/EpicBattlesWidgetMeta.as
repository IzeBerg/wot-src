package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesWidgetVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EpicBattlesWidgetMeta extends BaseDAAPIComponent
   {
       
      
      public var onWidgetClick:Function;
      
      public var onAnimationFinished:Function;
      
      public var onSoundTrigger:Function;
      
      private var _epicBattlesWidgetVO:EpicBattlesWidgetVO;
      
      public function EpicBattlesWidgetMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._epicBattlesWidgetVO)
         {
            this._epicBattlesWidgetVO.dispose();
            this._epicBattlesWidgetVO = null;
         }
         super.onDispose();
      }
      
      public function onWidgetClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onWidgetClick,"onWidgetClick" + Errors.CANT_NULL);
         this.onWidgetClick();
      }
      
      public function onAnimationFinishedS() : void
      {
         App.utils.asserter.assertNotNull(this.onAnimationFinished,"onAnimationFinished" + Errors.CANT_NULL);
         this.onAnimationFinished();
      }
      
      public function onSoundTriggerS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onSoundTrigger,"onSoundTrigger" + Errors.CANT_NULL);
         this.onSoundTrigger(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:EpicBattlesWidgetVO = this._epicBattlesWidgetVO;
         this._epicBattlesWidgetVO = new EpicBattlesWidgetVO(param1);
         this.setData(this._epicBattlesWidgetVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:EpicBattlesWidgetVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
