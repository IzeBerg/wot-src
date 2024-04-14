package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionAwardRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class PersonalMissionAwardRenderer extends UIComponentEx implements IUpdatableComponent
   {
       
      
      public var icon:UILoaderAlt;
      
      public var titleTf:TextField;
      
      public var hitMc:Sprite;
      
      private var _vo:PersonalMissionAwardRendererVO;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function PersonalMissionAwardRenderer()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onCmpRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onCmpRollOutHandler);
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
         this.icon.dispose();
         this.icon = null;
         this.titleTf = null;
         this.hitMc = null;
         this._toolTipMgr = null;
         this._vo = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.hitMc != null)
         {
            hitArea = this.hitMc;
            this.icon.mouseEnabled = this.icon.mouseChildren = false;
         }
         if(this.titleTf != null)
         {
            this.titleTf.visible = false;
         }
         addEventListener(MouseEvent.ROLL_OVER,this.onCmpRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onCmpRollOutHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._vo != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.icon.source = this._vo.icon;
               this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
               if(this.titleTf != null)
               {
                  this.titleTf.htmlText = this._vo.title;
                  this.titleTf.visible = StringUtils.isNotEmpty(this._vo.title);
               }
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               if(this.hitMc != null)
               {
                  this.hitMc.x = (this.icon.width - this.hitMc.width >> 1) + this.icon.x;
                  this.hitMc.y = (this.icon.height - this.hitMc.height >> 1) + this.icon.y;
               }
            }
         }
      }
      
      public function update(param1:Object) : void
      {
         this._vo = PersonalMissionAwardRendererVO(param1);
         invalidateData();
      }
      
      private function onIconCompleteHandler(param1:UILoaderEvent) : void
      {
         invalidateSize();
      }
      
      private function onCmpRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onCmpRollOverHandler(param1:MouseEvent) : void
      {
         if(this._vo.tooltip.isSpecial)
         {
            this._toolTipMgr.showSpecial.apply(this,[this._vo.tooltip.specialAlias,null].concat(this._vo.tooltip.specialArgs));
         }
         else
         {
            this._toolTipMgr.showComplex(this._vo.tooltip.tooltip);
         }
      }
   }
}
