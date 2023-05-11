package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesHangarWidgetVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RankedBattlesHangarWidgetMeta extends BaseDAAPIComponent
   {
       
      
      public var onWidgetClick:Function;
      
      public var onAnimationFinished:Function;
      
      public var onSoundTrigger:Function;
      
      public function RankedBattlesHangarWidgetMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
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
      
      public final function as_setData(param1:Array) : void
      {
         var _loc2_:Vector.<RankedBattlesHangarWidgetVO> = new Vector.<RankedBattlesHangarWidgetVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_[_loc4_] = new RankedBattlesHangarWidgetVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setData(_loc2_);
      }
      
      protected function setData(param1:Vector.<RankedBattlesHangarWidgetVO>) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
