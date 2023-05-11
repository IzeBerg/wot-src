package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class LobbyMenuMeta extends AbstractView
   {
       
      
      public var settingsClick:Function;
      
      public var cancelClick:Function;
      
      public var refuseTraining:Function;
      
      public var logoffClick:Function;
      
      public var quitClick:Function;
      
      public var postClick:Function;
      
      public var onCounterNeedUpdate:Function;
      
      public var bootcampClick:Function;
      
      public var onEscapePress:Function;
      
      public var manualClick:Function;
      
      private var _vectorCountersVo:Vector.<CountersVo>;
      
      private var _vectorString:Vector.<String>;
      
      public function LobbyMenuMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:CountersVo = null;
         if(this._vectorCountersVo)
         {
            for each(_loc1_ in this._vectorCountersVo)
            {
               _loc1_.dispose();
            }
            this._vectorCountersVo.splice(0,this._vectorCountersVo.length);
            this._vectorCountersVo = null;
         }
         if(this._vectorString)
         {
            this._vectorString.splice(0,this._vectorString.length);
            this._vectorString = null;
         }
         super.onDispose();
      }
      
      public function settingsClickS() : void
      {
         App.utils.asserter.assertNotNull(this.settingsClick,"settingsClick" + Errors.CANT_NULL);
         this.settingsClick();
      }
      
      public function cancelClickS() : void
      {
         App.utils.asserter.assertNotNull(this.cancelClick,"cancelClick" + Errors.CANT_NULL);
         this.cancelClick();
      }
      
      public function refuseTrainingS() : void
      {
         App.utils.asserter.assertNotNull(this.refuseTraining,"refuseTraining" + Errors.CANT_NULL);
         this.refuseTraining();
      }
      
      public function logoffClickS() : void
      {
         App.utils.asserter.assertNotNull(this.logoffClick,"logoffClick" + Errors.CANT_NULL);
         this.logoffClick();
      }
      
      public function quitClickS() : void
      {
         App.utils.asserter.assertNotNull(this.quitClick,"quitClick" + Errors.CANT_NULL);
         this.quitClick();
      }
      
      public function postClickS() : void
      {
         App.utils.asserter.assertNotNull(this.postClick,"postClick" + Errors.CANT_NULL);
         this.postClick();
      }
      
      public function onCounterNeedUpdateS() : void
      {
         App.utils.asserter.assertNotNull(this.onCounterNeedUpdate,"onCounterNeedUpdate" + Errors.CANT_NULL);
         this.onCounterNeedUpdate();
      }
      
      public function bootcampClickS() : void
      {
         App.utils.asserter.assertNotNull(this.bootcampClick,"bootcampClick" + Errors.CANT_NULL);
         this.bootcampClick();
      }
      
      public function onEscapePressS() : void
      {
         App.utils.asserter.assertNotNull(this.onEscapePress,"onEscapePress" + Errors.CANT_NULL);
         this.onEscapePress();
      }
      
      public function manualClickS() : void
      {
         App.utils.asserter.assertNotNull(this.manualClick,"manualClick" + Errors.CANT_NULL);
         this.manualClick();
      }
      
      public final function as_setCounter(param1:Array) : void
      {
         var _loc5_:CountersVo = null;
         var _loc2_:Vector.<CountersVo> = this._vectorCountersVo;
         this._vectorCountersVo = new Vector.<CountersVo>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorCountersVo[_loc4_] = new CountersVo(param1[_loc4_]);
            _loc4_++;
         }
         this.setCounter(this._vectorCountersVo);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_removeCounter(param1:Array) : void
      {
         var _loc2_:Vector.<String> = this._vectorString;
         this._vectorString = new Vector.<String>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorString[_loc4_] = param1[_loc4_];
            _loc4_++;
         }
         this.removeCounter(this._vectorString);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setCounter(param1:Vector.<CountersVo>) : void
      {
         var _loc2_:String = "as_setCounter" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function removeCounter(param1:Vector.<String>) : void
      {
         var _loc2_:String = "as_removeCounter" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
