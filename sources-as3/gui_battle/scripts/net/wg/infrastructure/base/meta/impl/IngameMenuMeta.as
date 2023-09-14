package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class IngameMenuMeta extends AbstractWindowView
   {
       
      
      public var quitBattleClick:Function;
      
      public var settingsClick:Function;
      
      public var helpClick:Function;
      
      public var cancelClick:Function;
      
      public var onCounterNeedUpdate:Function;
      
      private var _vectorCountersVo:Vector.<CountersVo>;
      
      private var _vectorString:Vector.<String>;
      
      private var _vectorString1:Vector.<String>;
      
      public function IngameMenuMeta()
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
         if(this._vectorString1)
         {
            this._vectorString1.splice(0,this._vectorString1.length);
            this._vectorString1 = null;
         }
         super.onDispose();
      }
      
      public function quitBattleClickS() : void
      {
         App.utils.asserter.assertNotNull(this.quitBattleClick,"quitBattleClick" + Errors.CANT_NULL);
         this.quitBattleClick();
      }
      
      public function settingsClickS() : void
      {
         App.utils.asserter.assertNotNull(this.settingsClick,"settingsClick" + Errors.CANT_NULL);
         this.settingsClick();
      }
      
      public function helpClickS() : void
      {
         App.utils.asserter.assertNotNull(this.helpClick,"helpClick" + Errors.CANT_NULL);
         this.helpClick();
      }
      
      public function cancelClickS() : void
      {
         App.utils.asserter.assertNotNull(this.cancelClick,"cancelClick" + Errors.CANT_NULL);
         this.cancelClick();
      }
      
      public function onCounterNeedUpdateS() : void
      {
         App.utils.asserter.assertNotNull(this.onCounterNeedUpdate,"onCounterNeedUpdate" + Errors.CANT_NULL);
         this.onCounterNeedUpdate();
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
      
      public final function as_setMenuButtons(param1:Array) : void
      {
         var _loc2_:Vector.<String> = this._vectorString1;
         this._vectorString1 = new Vector.<String>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorString1[_loc4_] = param1[_loc4_];
            _loc4_++;
         }
         this.setMenuButtons(this._vectorString1);
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
      
      protected function setMenuButtons(param1:Vector.<String>) : void
      {
         var _loc2_:String = "as_setMenuButtons" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
