package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.manual.data.ChapterItemRendererVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ManualMainViewMeta extends AbstractView
   {
       
      
      public var onChapterOpenedS:Function;
      
      public var closeView:Function;
      
      private var _vectorChapterItemRendererVO:Vector.<ChapterItemRendererVO>;
      
      public function ManualMainViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:ChapterItemRendererVO = null;
         if(this._vectorChapterItemRendererVO)
         {
            for each(_loc1_ in this._vectorChapterItemRendererVO)
            {
               _loc1_.dispose();
            }
            this._vectorChapterItemRendererVO.splice(0,this._vectorChapterItemRendererVO.length);
            this._vectorChapterItemRendererVO = null;
         }
         super.onDispose();
      }
      
      public function onChapterOpenedSS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onChapterOpenedS,"onChapterOpenedS" + Errors.CANT_NULL);
         this.onChapterOpenedS(param1);
      }
      
      public function closeViewS() : void
      {
         App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
         this.closeView();
      }
      
      public final function as_setChapters(param1:Array) : void
      {
         var _loc5_:ChapterItemRendererVO = null;
         var _loc2_:Vector.<ChapterItemRendererVO> = this._vectorChapterItemRendererVO;
         this._vectorChapterItemRendererVO = new Vector.<ChapterItemRendererVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorChapterItemRendererVO[_loc4_] = new ChapterItemRendererVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setChapters(this._vectorChapterItemRendererVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setChapters(param1:Vector.<ChapterItemRendererVO>) : void
      {
         var _loc2_:String = "as_setChapters" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
