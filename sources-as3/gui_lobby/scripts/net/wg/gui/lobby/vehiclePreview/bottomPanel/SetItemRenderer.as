package net.wg.gui.lobby.vehiclePreview.bottomPanel
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.SLOT_HIGHLIGHT_TYPES;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.vehiclePreview.data.VPSetItemVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   
   public class SetItemRenderer extends MovieClip implements IDisposable, ISoundable
   {
      
      private static const ICON_ALPHA_NORMAL:Number = 1;
      
      private static const ALPHA_ICON_COMPENSATION:Number = 0.5;
       
      
      public var image:Image;
      
      public var counterTF:TextField;
      
      public var compensationStatus:Image;
      
      public var overlayType:MovieClip;
      
      private var _disposed:Boolean = false;
      
      public function SetItemRenderer()
      {
         super();
         this.counterTF.mouseWheelEnabled = this.counterTF.mouseEnabled = this.image.mouseEnabled = false;
         mouseChildren = false;
         if(App.soundMgr != null)
         {
            App.soundMgr.addSoundsHdlrs(this);
         }
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return true;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         if(App.soundMgr != null)
         {
            App.soundMgr.removeSoundHdlrs(this);
         }
         this.image.dispose();
         this.image = null;
         this.counterTF = null;
         this.overlayType = null;
         this.compensationStatus.dispose();
         this.compensationStatus = null;
      }
      
      public function getSoundId() : String
      {
         return null;
      }
      
      public function getSoundType() : String
      {
         return SoundTypes.RNDR_NORMAL;
      }
      
      public function setData(param1:VPSetItemVO) : void
      {
         this.image.sourceAlt = param1.iconAlt;
         this.image.source = param1.icon || param1.iconAlt;
         this.image.alpha = !!param1.hasCompensation ? Number(ALPHA_ICON_COMPENSATION) : Number(ICON_ALPHA_NORMAL);
         this.compensationStatus.visible = param1.hasCompensation;
         if(this.compensationStatus.visible)
         {
            this.compensationStatus.source = RES_ICONS.MAPS_ICONS_LIBRARY_COMPLETEDINDICATOR;
         }
         this.overlayType.visible = param1.overlayType != SLOT_HIGHLIGHT_TYPES.NO_HIGHLIGHT;
         if(this.overlayType.visible)
         {
            this.overlayType.gotoAndStop(param1.overlayType);
         }
         if(param1.count)
         {
            this.counterTF.text = param1.count;
         }
         buttonMode = param1.rawData != null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
