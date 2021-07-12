package net.wg.gui.lobby.questsWindow.components
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.BaseTooltips;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.lobby.questsWindow.data.TextBlockVO;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class QuestTextAwardBlock extends AbstractResizableContent
   {
      
      private static const MAX_TOOLTIP_WIDTH:int = 300;
      
      private static const TEXT_FIELD_PADDING:int = 5;
       
      
      public var textTf:TextField;
      
      private var _tooltip:String;
      
      private var _isTooltipComplex:Boolean = false;
      
      public function QuestTextAwardBlock()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         var _loc2_:TextBlockVO = new TextBlockVO(param1);
         var _loc3_:Vector.<String> = _loc2_.items;
         var _loc4_:String = _loc2_.separator;
         var _loc5_:String = _loc3_.join(_loc4_) + _loc2_.endline;
         var _loc6_:Number = this.textTf.height;
         var _loc7_:int = _loc4_.length;
         var _loc8_:String = _loc2_.ellipsis;
         var _loc9_:int = _loc3_.length;
         this.textTf.htmlText = _loc5_;
         while(this.textTf.textHeight + TEXT_FIELD_PADDING > _loc6_)
         {
            this.textTf.htmlText = _loc5_.substr(0,this.getItemsStringLen(_loc3_,--_loc9_,_loc7_)) + _loc8_;
         }
         if(_loc9_ == 0)
         {
            DebugUtils.LOG_WARNING("Warn: not one items can be visible. Full items text: " + _loc5_);
         }
         else
         {
            App.utils.commons.updateTextFieldSize(this.textTf,false,true);
            setSize(width,actualHeight);
            if(this.textTf.htmlText != _loc5_)
            {
               this.textTf.addEventListener(MouseEvent.ROLL_OVER,this.onTextTfRollOverHandler);
               this.textTf.addEventListener(MouseEvent.ROLL_OUT,this.onTextTfRollOutHandler);
               this._isTooltipComplex = StringUtils.isNotEmpty(_loc2_.complexTooltip);
               if(this._isTooltipComplex)
               {
                  this._tooltip = _loc2_.complexTooltip;
               }
               else
               {
                  this._tooltip = _loc5_;
               }
            }
         }
         _loc2_.dispose();
      }
      
      override protected function onDispose() : void
      {
         this.textTf.removeEventListener(MouseEvent.ROLL_OVER,this.onTextTfRollOverHandler);
         this.textTf.removeEventListener(MouseEvent.ROLL_OUT,this.onTextTfRollOutHandler);
         this.textTf = null;
         super.onDispose();
      }
      
      private function getItemsStringLen(param1:Vector.<String>, param2:int, param3:int) : int
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < param2)
         {
            _loc4_ += param1[_loc5_].length + param3;
            _loc5_++;
         }
         return _loc4_;
      }
      
      private function onTextTfRollOverHandler(param1:MouseEvent) : void
      {
         if(this._isTooltipComplex)
         {
            App.toolTipMgr.showComplex(this._tooltip);
         }
         else
         {
            App.toolTipMgr.show(this._tooltip,new TooltipProps(BaseTooltips.TYPE_INFO,0,0,0,-1,0,MAX_TOOLTIP_WIDTH));
         }
      }
      
      private function onTextTfRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
