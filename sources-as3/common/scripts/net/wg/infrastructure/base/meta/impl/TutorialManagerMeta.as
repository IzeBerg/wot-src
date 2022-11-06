package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.TutorialBuilderVO;
   import net.wg.data.TutorialComponentData;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIModule;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class TutorialManagerMeta extends BaseDAAPIModule
   {
       
      
      public var onComponentFound:Function;
      
      public var onComponentDisposed:Function;
      
      public var onTriggerActivated:Function;
      
      public var onEffectCompleted:Function;
      
      public var onUbTrackedVarChanged:Function;
      
      private var _array1:Array;
      
      private var _tutorialBuilderVO:TutorialBuilderVO;
      
      private var _tutorialComponentData:TutorialComponentData;
      
      private var _tutorialComponentData1:TutorialComponentData;
      
      public function TutorialManagerMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._array1)
         {
            this._array1.splice(0,this._array1.length);
            this._array1 = null;
         }
         if(this._tutorialBuilderVO)
         {
            this._tutorialBuilderVO.dispose();
            this._tutorialBuilderVO = null;
         }
         if(this._tutorialComponentData)
         {
            this._tutorialComponentData.dispose();
            this._tutorialComponentData = null;
         }
         if(this._tutorialComponentData1)
         {
            this._tutorialComponentData1.dispose();
            this._tutorialComponentData1 = null;
         }
         super.onDispose();
      }
      
      public function onComponentFoundS(param1:String, param2:String) : Array
      {
         App.utils.asserter.assertNotNull(this.onComponentFound,"onComponentFound" + Errors.CANT_NULL);
         return this.onComponentFound(param1,param2);
      }
      
      public function onComponentDisposedS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onComponentDisposed,"onComponentDisposed" + Errors.CANT_NULL);
         this.onComponentDisposed(param1);
      }
      
      public function onTriggerActivatedS(param1:String, param2:String, param3:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onTriggerActivated,"onTriggerActivated" + Errors.CANT_NULL);
         this.onTriggerActivated(param1,param2,param3);
      }
      
      public function onEffectCompletedS(param1:String, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.onEffectCompleted,"onEffectCompleted" + Errors.CANT_NULL);
         this.onEffectCompleted(param1,param2);
      }
      
      public function onUbTrackedVarChangedS(param1:String, param2:String, param3:String, param4:Object) : void
      {
         App.utils.asserter.assertNotNull(this.onUbTrackedVarChanged,"onUbTrackedVarChanged" + Errors.CANT_NULL);
         this.onUbTrackedVarChanged(param1,param2,param3,param4);
      }
      
      public final function as_setTriggers(param1:String, param2:Array) : void
      {
         var _loc3_:Array = this._array1;
         this._array1 = param2;
         this.setTriggers(param1,this._array1);
         if(_loc3_)
         {
            _loc3_.splice(0,_loc3_.length);
         }
      }
      
      public final function as_showEffect(param1:String, param2:String, param3:String, param4:Object) : void
      {
         var _loc5_:TutorialBuilderVO = this._tutorialBuilderVO;
         this._tutorialBuilderVO = new TutorialBuilderVO(param4);
         this.showEffect(param1,param2,param3,this._tutorialBuilderVO);
         if(_loc5_)
         {
            _loc5_.dispose();
         }
      }
      
      public final function as_externalComponentFound(param1:String, param2:String, param3:Object) : void
      {
         var _loc4_:TutorialComponentData = this._tutorialComponentData;
         this._tutorialComponentData = new TutorialComponentData(param3);
         this.externalComponentFound(param1,param2,this._tutorialComponentData);
         if(_loc4_)
         {
            _loc4_.dispose();
         }
      }
      
      public final function as_updateExternalComponent(param1:String, param2:String, param3:Object) : void
      {
         var _loc4_:TutorialComponentData = this._tutorialComponentData1;
         this._tutorialComponentData1 = new TutorialComponentData(param3);
         this.updateExternalComponent(param1,param2,this._tutorialComponentData1);
         if(_loc4_)
         {
            _loc4_.dispose();
         }
      }
      
      protected function setTriggers(param1:String, param2:Array) : void
      {
         var _loc3_:String = "as_setTriggers" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
      
      protected function showEffect(param1:String, param2:String, param3:String, param4:TutorialBuilderVO) : void
      {
         var _loc5_:String = "as_showEffect" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc5_);
         throw new AbstractException(_loc5_);
      }
      
      protected function externalComponentFound(param1:String, param2:String, param3:TutorialComponentData) : void
      {
         var _loc4_:String = "as_externalComponentFound" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc4_);
         throw new AbstractException(_loc4_);
      }
      
      protected function updateExternalComponent(param1:String, param2:String, param3:TutorialComponentData) : void
      {
         var _loc4_:String = "as_updateExternalComponent" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc4_);
         throw new AbstractException(_loc4_);
      }
   }
}
