package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.hangar.data.HangarHeaderVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class HangarHeaderMeta extends BaseDAAPIComponent
   {
       
      
      public var onQuestBtnClick:Function;
      
      private var _hangarHeaderVO:HangarHeaderVO;
      
      public function HangarHeaderMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._hangarHeaderVO)
         {
            this._hangarHeaderVO.dispose();
            this._hangarHeaderVO = null;
         }
         super.onDispose();
      }
      
      public function onQuestBtnClickS(param1:String, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.onQuestBtnClick,"onQuestBtnClick" + Errors.CANT_NULL);
         this.onQuestBtnClick(param1,param2);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:HangarHeaderVO = this._hangarHeaderVO;
         this._hangarHeaderVO = new HangarHeaderVO(param1);
         this.setData(this._hangarHeaderVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:HangarHeaderVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
