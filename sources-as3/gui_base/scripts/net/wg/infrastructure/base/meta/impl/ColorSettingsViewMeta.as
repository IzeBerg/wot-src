package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.colorSettings.vo.ColorSettingsUpdateVO;
   import net.wg.gui.lobby.colorSettings.vo.ColorSettingsVO;
   import net.wg.infrastructure.base.AbstractScreen;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ColorSettingsViewMeta extends AbstractScreen
   {
       
      
      public var onClose:Function;
      
      public var onApply:Function;
      
      public var onReset:Function;
      
      public var onSettingsChange:Function;
      
      public var onTabSelected:Function;
      
      public var setViewWidth:Function;
      
      public var moveSpace:Function;
      
      private var _colorSettingsVO:ColorSettingsVO;
      
      private var _colorSettingsUpdateVO:ColorSettingsUpdateVO;
      
      public function ColorSettingsViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 28
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
      
      public function onCloseS() : void
      {
         App.utils.asserter.assertNotNull(this.onClose,"onClose" + Errors.CANT_NULL);
         this.onClose();
      }
      
      public function onApplyS(param1:Object) : void
      {
         App.utils.asserter.assertNotNull(this.onApply,"onApply" + Errors.CANT_NULL);
         this.onApply(param1);
      }
      
      public function onResetS() : void
      {
         App.utils.asserter.assertNotNull(this.onReset,"onReset" + Errors.CANT_NULL);
         this.onReset();
      }
      
      public function onSettingsChangeS(param1:String, param2:Object) : void
      {
         App.utils.asserter.assertNotNull(this.onSettingsChange,"onSettingsChange" + Errors.CANT_NULL);
         this.onSettingsChange(param1,param2);
      }
      
      public function onTabSelectedS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onTabSelected,"onTabSelected" + Errors.CANT_NULL);
         this.onTabSelected(param1);
      }
      
      public function setViewWidthS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.setViewWidth,"setViewWidth" + Errors.CANT_NULL);
         this.setViewWidth(param1);
      }
      
      public function moveSpaceS(param1:Number, param2:Number, param3:Number) : void
      {
         App.utils.asserter.assertNotNull(this.moveSpace,"moveSpace" + Errors.CANT_NULL);
         this.moveSpace(param1,param2,param3);
      }
      
      public final function as_initData(param1:Object) : void
      {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 23
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
      
      public final function as_updateData(param1:int, param2:Object) : void
      {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 24
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
      
      protected function initData(param1:ColorSettingsVO) : void
      {
         var _loc2_:String = "as_initData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateData(param1:int, param2:ColorSettingsUpdateVO) : void
      {
         var _loc3_:String = "as_updateData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
