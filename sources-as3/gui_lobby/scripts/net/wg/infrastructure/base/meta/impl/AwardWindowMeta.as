package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.data.AwardWindowVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class AwardWindowMeta extends AbstractWindowView
   {
       
      
      public var onOKClick:Function;
      
      public var onTakeNextClick:Function;
      
      public var onCloseClick:Function;
      
      private var _awardWindowVO:AwardWindowVO;
      
      public function AwardWindowMeta()
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
      
      public function onOKClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onOKClick,"onOKClick" + Errors.CANT_NULL);
         this.onOKClick();
      }
      
      public function onTakeNextClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onTakeNextClick,"onTakeNextClick" + Errors.CANT_NULL);
         this.onTakeNextClick();
      }
      
      public function onCloseClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onCloseClick,"onCloseClick" + Errors.CANT_NULL);
         this.onCloseClick();
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
