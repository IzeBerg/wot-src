package net.wg.gui.lobby.missions.components
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.TableRenderer;
   import net.wg.gui.lobby.missions.data.TokenRendererVO;
   import net.wg.gui.lobby.missions.event.MissionsTokenListRendererEvent;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class MissionsTokenListRenderer extends TableRenderer
   {
      
      private static const DESCR_TF_IMG_OFFSET:int = 20;
       
      
      public var headerTF:TextField = null;
      
      public var descrTF:TextField = null;
      
      public var arrow:Sprite = null;
      
      public var img:IImage = null;
      
      private var _questId:String = "";
      
      private var _tooltip:String = "";
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function MissionsTokenListRenderer()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         var _loc2_:TokenRendererVO = null;
         super.setData(param1);
         this._tooltipMgr.hide();
         if(param1 != null)
         {
            _loc2_ = TokenRendererVO(param1);
            this.headerTF.htmlText = _loc2_.headerText;
            this.descrTF.htmlText = _loc2_.descrText;
            this._questId = _loc2_.questId;
            this._tooltip = _loc2_.tooltip;
            this.img.visible = StringUtils.isNotEmpty(_loc2_.imgSrc);
            if(this.img.visible)
            {
               this.img.source = _loc2_.imgSrc;
               this.descrTF.x = this.headerTF.x + DESCR_TF_IMG_OFFSET;
            }
            else
            {
               this.descrTF.x = this.headerTF.x;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.headerTF = null;
         this.descrTF = null;
         this.arrow = null;
         this.img.dispose();
         this.img = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function handleClick(param1:uint = 0) : void
      {
         super.handleClick(param1);
         dispatchEvent(new MissionsTokenListRendererEvent(MissionsTokenListRendererEvent.QUEST_RENDERER_CLICK,this._questId,true));
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         this._tooltipMgr.showComplex(this._tooltip);
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         this._tooltipMgr.hide();
      }
   }
}
