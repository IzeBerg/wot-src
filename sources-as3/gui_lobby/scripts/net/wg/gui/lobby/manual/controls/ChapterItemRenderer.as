package net.wg.gui.lobby.manual.controls
{
   import flash.text.TextFormat;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.manual.data.ChapterItemRendererVO;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.ICounterProps;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.TextFieldEx;
   
   public class ChapterItemRenderer extends SoundButtonEx
   {
      
      private static const FONT_SMALL:int = 21;
      
      private static const FONT_NORMAL:int = 30;
      
      private static const COUNTER_PROPS_SMALL:CounterProps = new CounterProps(-16,14);
      
      private static const COUNTER_PROPS:CounterProps = new CounterProps(-26,21);
       
      
      public var loader:UILoaderAlt = null;
      
      private var _counterMgr:ICounterManager;
      
      public function ChapterItemRenderer()
      {
         this._counterMgr = App.utils.counterManager;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.loader.mouseChildren = false;
         this.loader.mouseEnabled = false;
         TextFieldEx.setVerticalAlign(textField,TextFieldEx.VALIGN_CENTER);
         displayFocus = false;
      }
      
      override protected function onDispose() : void
      {
         this.loader.dispose();
         this.loader = null;
         this._counterMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:TextFormat = null;
         var _loc2_:Boolean = false;
         var _loc3_:ChapterItemRendererVO = null;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = textField.getTextFormat();
            _loc2_ = scaleX < 1;
            _loc1_.size = !!_loc2_ ? FONT_SMALL : FONT_NORMAL;
            textField.setTextFormat(_loc1_);
            _loc3_ = ChapterItemRendererVO(data);
            if(_loc3_ && StringUtils.isNotEmpty(_loc3_.counter))
            {
               this._counterMgr.setCounter(this,_loc3_.counter,null,!!_loc2_ ? COUNTER_PROPS_SMALL : COUNTER_PROPS);
            }
            else
            {
               this._counterMgr.removeCounter(this);
            }
         }
      }
      
      override public function set data(param1:Object) : void
      {
         super.data = param1;
         var _loc2_:ChapterItemRendererVO = ChapterItemRendererVO(data);
         this.loader.source = _loc2_.image;
         label = _loc2_.label;
         tooltip = _loc2_.tooltip;
      }
   }
}
