package net.wg.gui.components.advanced
{
   import flash.display.MovieClip;
   import net.wg.gui.components.advanced.vo.StaticItemSlotVO;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class StaticItemSlot extends UIComponentEx
   {
       
      
      public var greenBorderMc:MovieClip = null;
      
      public var bg:MovieClip = null;
      
      public var moduleType:ModuleTypesUIWithFill = null;
      
      public var iconLoader:UILoaderAlt = null;
      
      public var equipSlotOverlay:MovieClip = null;
      
      public var equipSlotHighlight:MovieClip = null;
      
      private var _data:StaticItemSlotVO = null;
      
      public function StaticItemSlot()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         this.greenBorderMc = null;
         this.bg = null;
         this.moduleType.dispose();
         this.moduleType = null;
         this.iconLoader.dispose();
         this.iconLoader = null;
         this.equipSlotOverlay = null;
         this.equipSlotHighlight = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.equipSlotHighlight.mouseEnabled = this.equipSlotOverlay.mouseEnabled = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._data)
            {
               if(this._data.moduleType)
               {
                  this.moduleType.setModuleTypeIcon(this._data.moduleType);
                  this.moduleType.visible = true;
               }
               else if(this._data.iconSource)
               {
                  this.iconLoader.source = this._data.iconSource;
                  if(this.iconLoader.visible)
                  {
                     this.iconLoader.visible = true;
                  }
               }
               this.greenBorderMc.visible = this._data.highlight;
               _loc1_ = StringUtils.isNotEmpty(this._data.overlayType);
               this.equipSlotOverlay.visible = _loc1_;
               if(_loc1_)
               {
                  this.equipSlotOverlay.gotoAndStop(this._data.overlayType);
               }
               _loc2_ = StringUtils.isNotEmpty(this._data.bgHighlightType);
               this.equipSlotHighlight.visible = _loc2_;
               if(_loc2_)
               {
                  this.equipSlotHighlight.gotoAndStop(this._data.bgHighlightType);
               }
               this.bg.visible = this._data.isBgVisible;
            }
            else
            {
               this.clear();
            }
         }
      }
      
      public function setup(param1:StaticItemSlotVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function clear() : void
      {
         this.greenBorderMc.visible = false;
         this.moduleType.visible = false;
         if(this.moduleType.visible)
         {
            this.iconLoader.visible = false;
         }
         this.equipSlotOverlay.visible = this.equipSlotHighlight.visible = false;
      }
   }
}
