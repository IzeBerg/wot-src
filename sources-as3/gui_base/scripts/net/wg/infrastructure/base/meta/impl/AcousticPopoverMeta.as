package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.popover.vo.AcousticPopoverVo;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class AcousticPopoverMeta extends SmartPopOverView
   {
       
      
      public var onActionStart:Function;
      
      public var onSpeakerClick:Function;
      
      private var _acousticPopoverVo:AcousticPopoverVo;
      
      private var _array:Array;
      
      private var _array1:Array;
      
      public function AcousticPopoverMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._acousticPopoverVo)
         {
            this._acousticPopoverVo.dispose();
            this._acousticPopoverVo = null;
         }
         if(this._array)
         {
            this._array.splice(0,this._array.length);
            this._array = null;
         }
         if(this._array1)
         {
            this._array1.splice(0,this._array1.length);
            this._array1 = null;
         }
         super.onDispose();
      }
      
      public function onActionStartS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onActionStart,"onActionStart" + Errors.CANT_NULL);
         this.onActionStart(param1);
      }
      
      public function onSpeakerClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onSpeakerClick,"onSpeakerClick" + Errors.CANT_NULL);
         this.onSpeakerClick(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:AcousticPopoverVo = this._acousticPopoverVo;
         this._acousticPopoverVo = new AcousticPopoverVo(param1);
         this.setData(this._acousticPopoverVo);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_onItemPlay(param1:Array) : void
      {
         var _loc2_:Array = this._array;
         this._array = param1;
         this.onItemPlay(this._array);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_onItemSelect(param1:Array) : void
      {
         var _loc2_:Array = this._array1;
         this._array1 = param1;
         this.onItemSelect(this._array1);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setData(param1:AcousticPopoverVo) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function onItemPlay(param1:Array) : void
      {
         var _loc2_:String = "as_onItemPlay" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function onItemSelect(param1:Array) : void
      {
         var _loc2_:String = "as_onItemSelect" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
