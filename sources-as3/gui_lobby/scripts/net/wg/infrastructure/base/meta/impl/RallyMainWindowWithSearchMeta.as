package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.cyberSport.vo.AutoSearchVO;
   import net.wg.gui.rally.BaseRallyMainWindow;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RallyMainWindowWithSearchMeta extends BaseRallyMainWindow
   {
       
      
      public var onAutoMatch:Function;
      
      public var autoSearchApply:Function;
      
      public var autoSearchCancel:Function;
      
      private var _autoSearchVO:AutoSearchVO;
      
      public function RallyMainWindowWithSearchMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._autoSearchVO)
         {
            this._autoSearchVO.dispose();
            this._autoSearchVO = null;
         }
         super.onDispose();
      }
      
      public function onAutoMatchS(param1:String, param2:Array) : void
      {
         App.utils.asserter.assertNotNull(this.onAutoMatch,"onAutoMatch" + Errors.CANT_NULL);
         this.onAutoMatch(param1,param2);
      }
      
      public function autoSearchApplyS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.autoSearchApply,"autoSearchApply" + Errors.CANT_NULL);
         this.autoSearchApply(param1);
      }
      
      public function autoSearchCancelS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.autoSearchCancel,"autoSearchCancel" + Errors.CANT_NULL);
         this.autoSearchCancel(param1);
      }
      
      public final function as_changeAutoSearchState(param1:Object) : void
      {
         var _loc2_:AutoSearchVO = this._autoSearchVO;
         this._autoSearchVO = Boolean(param1) ? new AutoSearchVO(param1) : null;
         this.changeAutoSearchState(this._autoSearchVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function changeAutoSearchState(param1:AutoSearchVO) : void
      {
         var _loc2_:String = "as_changeAutoSearchState" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
