package net.wg.gui.lobby.settings.vo.config
{
   import net.wg.gui.lobby.settings.config.ControlsFactory;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   
   public class ControlsSettingsDataVo extends SettingsDataVo
   {
       
      
      public var keyboardImportantBinds:Vector.<String>;
      
      public var keysLayoutOrder:Vector.<String> = null;
      
      public var keyboard:SettingsDataVo = null;
      
      public var mouseHorzInvert:SettingsControlProp = null;
      
      public var mouseArcadeSens:SettingsControlProp = null;
      
      public var mouseVertInvert:SettingsControlProp = null;
      
      public var mouseSniperSens:SettingsControlProp = null;
      
      public var mouseStrategicSens:SettingsControlProp = null;
      
      public var mouseAssistAimSens:SettingsControlProp = null;
      
      public var backDraftInvert:SettingsControlProp = null;
      
      public function ControlsSettingsDataVo()
      {
         super({
            "keysLayoutOrder":new Vector.<String>(),
            "keyboard":new SettingsDataVo({}),
            "mouseHorzInvert":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "mouseArcadeSens":createControl(ControlsFactory.TYPE_SLIDER).build(),
            "mouseVertInvert":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "mouseSniperSens":createControl(ControlsFactory.TYPE_SLIDER).build(),
            "mouseStrategicSens":createControl(ControlsFactory.TYPE_SLIDER).build(),
            "mouseAssistAimSens":createControl(ControlsFactory.TYPE_SLIDER).build(),
            "backDraftInvert":createControl(ControlsFactory.TYPE_CHECKBOX).build()
         });
      }
      
      override protected function onDispose() : void
      {
         if(this.keyboardImportantBinds)
         {
            this.keyboardImportantBinds.splice(0,this.keyboardImportantBinds.length);
            this.keyboardImportantBinds = null;
         }
         this.keysLayoutOrder = null;
         this.keyboard = null;
         this.mouseHorzInvert = null;
         this.mouseArcadeSens = null;
         this.mouseVertInvert = null;
         this.mouseSniperSens = null;
         this.mouseStrategicSens = null;
         this.mouseAssistAimSens = null;
         this.backDraftInvert = null;
         super.onDispose();
      }
   }
}
