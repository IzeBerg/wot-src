package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.data.AwardWindowVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class AwardWindowsBaseMeta extends AbstractWindowView
   {
       
      
      private var _awardWindowVO:AwardWindowVO;
      
      public function AwardWindowsBaseMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._awardWindowVO)
         {
            this._awardWindowVO.dispose();
            this._awardWindowVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:AwardWindowVO = this._awardWindowVO;
         this._awardWindowVO = new AwardWindowVO(param1);
         this.setData(this._awardWindowVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:AwardWindowVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
