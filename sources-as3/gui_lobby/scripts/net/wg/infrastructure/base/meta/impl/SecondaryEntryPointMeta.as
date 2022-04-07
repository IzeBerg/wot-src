package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.hangar.data.SecondaryEntryPointVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class SecondaryEntryPointMeta extends BaseDAAPIComponent
   {
       
      
      public var onClick:Function;
      
      private var _secondaryEntryPointVO:SecondaryEntryPointVO;
      
      public function SecondaryEntryPointMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._secondaryEntryPointVO)
         {
            this._secondaryEntryPointVO.dispose();
            this._secondaryEntryPointVO = null;
         }
         super.onDispose();
      }
      
      public function onClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onClick,"onClick" + Errors.CANT_NULL);
         this.onClick();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:SecondaryEntryPointVO = this._secondaryEntryPointVO;
         this._secondaryEntryPointVO = new SecondaryEntryPointVO(param1);
         this.setData(this._secondaryEntryPointVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:SecondaryEntryPointVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
